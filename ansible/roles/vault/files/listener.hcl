ui=true

storage "inmem" {}

listener "tcp" {
   address = "10.20.11.160:80"
   tls_disable = 1
}
