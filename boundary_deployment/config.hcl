# Boundary Configuration
disable_mlock = true

listener "tcp" {
  address = "0.0.0.0:9202"
  purpose = "proxy"
}

worker {
  # name = "local-guy"
  initial_upstreams = ["a57089aaf0da84c97b37e9817a173c76-1877085223.eu-west-2.elb.amazonaws.com:9202" ]
   auth_storage_path = "./file/dockerlab/storage/"
  # recording_storage_path = "./file/dockerlab/recording/"
 # controller_generated_activation_token
 # public_addr = "localhost:9202"
  tags {
    type = ["local"]
  }

}
sink "stderr" {
    name = "all-events"
    description = "All events sent to stderr"
    event_types = ["*"]
    format = "hclog-text"
}




