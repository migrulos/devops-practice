 resource "google_compute_global_address" "www" {                                  
     name = "www-address"                                                          
 }                                                                                 
                                                                                   
 resource "google_compute_global_forwarding_rule" "http" {                         
     name = "http-forwarding-rule"                                                 
     ip_address = "${google_compute_global_address.www.address}"                   
     target = "${google_compute_target_http_proxy.http_proxy.self_link}"           
     port_range = "80"                                                             
 }                                                                                 

#resource "google_compute_firewall" "open-port-example" {   
#    name = "open-port-example"                             
#    network = "default"                                    
#    allow {                                                
#        protocol = "tcp"                                   
#        ports = ["5000"]                                   
#    }                                                      
#    source_ranges = ["0.0.0.0/0"]                          
#    target_tags = ["open-5000tcp"]                         
#}                                                           
