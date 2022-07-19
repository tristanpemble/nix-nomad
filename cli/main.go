package main

import (
	"context"
	"fmt"
	"github.com/gosuri/uilive"
	"github.com/hashicorp/nomad/api"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"math/rand"
	"os"
	"sort"
	"time"
)

func main() {
	const numJobs = 5

	jobNames := []string{
		"lb",
		"web",
		"api",
		"db",
		"cache",
		"search",
	}

	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})
	zerolog.TimeFieldFormat = zerolog.TimeFormatUnix

	ctx := context.Background()
	client, err := api.NewClient(api.DefaultConfig())
	if err != nil {
		log.Fatal().Err(err).Msg("cannot create Nomad API client")
	}

	stream, err := client.EventStream().Stream(ctx, map[api.Topic][]string{api.TopicEvaluation: jobNames}, 0, &api.QueryOptions{})
	if err != nil {
		log.Fatal().Err(err).Msg("cannot create event stream")
	}

	jobs := make(chan *api.Job, len(jobNames))
	results := make(chan *api.JobRegisterResponse, numJobs)

	for w := 1; w <= 3; w++ {
		go worker(client, w, jobs, results)
	}

	messages := make(map[string]string)
	for _, name := range jobNames {
		messages[name] = "submitting"
		jobs <- MakeJob(name)
	}
	close(jobs)

	for a := 1; a <= numJobs; a++ {
		<-results
	}

	w := uilive.New()
	w.Start()
	for events := range stream {
		for _, event := range events.Events {
			e, _ := event.Evaluation()
			messages[e.JobID] = event.Type
			Render(w, messages)
			time.Sleep(1*time.Second + 3*time.Second*time.Duration(rand.Float32()))
		}
	}
	w.Stop()
}

func Render(w *uilive.Writer, messages map[string]string) {
	keys := make([]string, 0)
	for key, _ := range messages {
		keys = append(keys, key)
	}
	sort.Strings(keys)
	for _, jobId := range keys {
		fmt.Fprintf(w.Newline(), "[%s] %s\n", jobId, messages[jobId])
	}
}

func MakeJob(name string) *api.Job {
	task := api.NewTask("web", "exec")
	group := api.NewTaskGroup("web", 1).AddTask(task)
	return api.NewServiceJob(name, name, "global", 50).AddDatacenter("dc1").AddTaskGroup(group)
}

func worker(client *api.Client, id int, jobs <-chan *api.Job, result chan *api.JobRegisterResponse) {
	for job := range jobs {
		res, _, _ := client.Jobs().Register(job, &api.WriteOptions{})
		result <- res
	}
}
