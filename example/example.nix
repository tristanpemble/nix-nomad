{
  jobs.docs = {
    type = "service";
    datacenters = ["us-west-1" "us-east-1"];

    groups.webs = {
      count = 1;

      tasks.frontend = {
        driver = "docker";

        config = {
          image = "hashicorp/web-frontend";
          ports = ["http" "https"];
        };
      };
    };
  };
}
