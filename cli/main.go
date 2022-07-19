package main

import (
	"fmt"
	"github.com/gosuri/uilive"
	"github.com/hashicorp/nomad/api"
	"math/rand"
	"time"
)

func main() {
	const numJobs = 5

	jobs := make(chan *DispatchJob, numJobs)
	results := make(chan error, numJobs)

	for w := 1; w <= 3; w++ {
		go worker(w, jobs, results)
	}

	writer := uilive.New()
	writer.Start()

	for i := 0; i < 10; i++ {
		jobs <- &DispatchJob{
			id:     i,
			status: "waiting",
			job:    api.Job{},
		}
	}
	close(jobs)

	for a := 1; a <= numJobs; a++ {
		<-results
	}
}

func worker(id int, jobs <-chan *DispatchJob, result chan<- error) {
	for j := range jobs {
		fmt.Println("worker", id, "started  job")
		j.Dispatch()
		fmt.Println("worker", id, "finished job")
		result <- nil
	}
}

type DispatchJob struct {
	id     int
	status string
	job    api.Job
}

func (j *DispatchJob) Dispatch() {
	<-time.After(1*time.Second + 5*time.Second*time.Duration(rand.Float32()))
	//c, err := RenderConfigs(jobs)
	//for _, id := range jobs {
	//	job, err := ReadJobFile(id)
	//	request, err := BuildApplyRequest(job)
	//	response, err := SendRequest(request)
	//	evaluation, err := ParseResponse(response)
	//	for {
	//		status, err := CheckEvaluation(evaluation)
	//		if status == "done" {
	//			break
	//		}
	//	}
	//}
}
