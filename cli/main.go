package main

import (
	"fmt"
	"github.com/gosuri/uilive"
	"math/rand"
	"sync"
	"time"
)

func main() {
	wg := &sync.WaitGroup{}

	writer := uilive.New()
	writer.Start()

	var progress []int
	for i := 0; i < 10; i++ {
		i := i
		progress = append(progress, 0)

		p := make(chan int, 1)

		wg.Add(1)

		// Start download
		go download(p, wg)

		// Track progress
		go func() {
			select {
			case p := <-p:
				progress[i] = p
				writeProgress(progress, writer)
			}
		}()

	}
	wg.Wait()
	writer.Stop()
}

func writeProgress(progress []int, writer *uilive.Writer) {
	for i, p := range progress {
		_, _ = fmt.Fprintf(writer.Newline(), "[%d] progress %d\n", i, p)
	}
	writer.Flush()
}

func worker(id int, jobs <-chan int, result chan<- int) {
	for j := range jobs {
		fmt.Println("worker", id, "started  job", j)
		time.Sleep(time.Second)
		fmt.Println("worker", id, "finished job", j)
		results <- j * 2
	}
}

func download(p chan int, wg *sync.WaitGroup) {
	for j := 0; j <= 100; j++ {
		p <- j
		<-time.After(time.Millisecond * time.Duration(10*rand.Float32()))
	}
	wg.Done()
}

type WorkerLog struct {
	buffer []string
}

func DoTheDeploy(jobs []int) err {
	c, err := RenderConfigs(jobs)
	for _, id := range jobs {
		job, err := ReadJobFile(id)
		request, err := BuildApplyRequest(job)
		response, err := SendRequest(request)
		evaluation, err := ParseResponse(response)
		for {
			status, err := CheckEvaluation(evaluation)
			if status == "done" {
				break
			}
		}
	}
}
