module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  #version = "8.2.0"
  name    = "my-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  #vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets         =  module.vpc.public_subnets  #[module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  #subnets         = data.terraform_remote_state.vpc.outputs.public_subnets
  security_groups = [module.loadbalancer_sg.security_group_id]
  #listeners
  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
      #target_group_index = 0
    }

  ]
  # target group
  target_groups = [
    #App1 target group
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
    },
  ]
  #HTTPS Listener
  https_listeners = [
    # HTTPS Listener Index = 0 for HTTPS 443
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = module.acm.acm_certificate_arn
      action_type     = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }
    },
  ]
  # HTTPS Listener Rules
  https_listener_rules = [
    # Rule-1: /app1* should go to App1 EC2 Instances
    {
      https_listener_index = 0
      priority             = 1
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        path_patterns = ["/*"]
        # host_headers = [var.app1_dns_name]

      }]
    },
  ]

  tags = {
    Name = "Test"
  }


}
