resource "google_compute_target_http_proxy" "http_proxy" {                               
    name = "http-proxy"                                                                  
    url_map = "${google_compute_url_map.default.self_link}"                              
}                                                                                        
                                                                                         
resource "google_compute_url_map" "default" {                                            
    name = "url-map"                                                                     
    default_service = "${google_compute_backend_service.default.self_link}"              
}                                                                                        
                                                                                         
resource "google_compute_backend_service" "default" {                                    
    name = "backend-service"                                                             
    backend {                                                                            
        group = "${google_compute_instance_group.instance_group.self_link}"              
    }                                                                                    
    health_checks = ["${google_compute_http_health_check.http-hc.self_link}"]            
}                                                                                        
                                                                                         
resource "google_compute_http_health_check" "http-hc" {                                  
    name = "http-health-check"                                                           
    timeout_sec = 3                                                                      
    check_interval_sec = 4                                                               
}                                                                                        
