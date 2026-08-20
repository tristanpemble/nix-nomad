package main

import (
	"context"
	"errors"
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"pemble.dev/nix-nomad/cli/command"
)

var version = "development"

func main() {
	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	if err := command.Run(ctx, version, os.Args[1:], os.Stdin, os.Stdout, os.Stderr); err != nil {
		var exitError *command.ExitError
		if errors.As(err, &exitError) {
			if exitError.Err != nil {
				fmt.Fprintf(os.Stderr, "nix-nomad: %v\n", exitError.Err)
			}
			os.Exit(exitError.Code)
		}

		fmt.Fprintf(os.Stderr, "nix-nomad: %v\n", err)
		os.Exit(1)
	}
}
