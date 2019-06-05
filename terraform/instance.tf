resource "google_compute_instance_group" "instance_group" {                           
    name = "instance-group"                                                           
    zone = "europe-west1-b"                                                           
    instances = "${google_compute_instance.example-instance.*.self_link}"             
}                                                                                     
                                                                                      
resource "google_compute_instance" "example-instance" {                               
  count        = 2                                                                    
  name         = "example-name-${count.index}"                                        
  machine_type = "f1-micro"                                                           
  zone         = "europe-west1-b"                                                     
  boot_disk {                                                                         
    initialize_params {                                                               
      image = "centos-7"                                                              
    }                                                                                 
  }                                                                                   
  #    tags = ["open-5000tcp"]                                                        
  tags = ["http-server"]                                                              
                                                                                      
  scheduling {                                                                        
      preemptible = true                                                              
      automatic_restart = false                                                       
    }                                                                                 
                                                                                      
  ### changed to project_metadata with "ssh-keys" instead of "sshKeys"                
  #metadata = {                                                                       
  #  sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"                
  #}                                                                                  
                                                                                      
  network_interface {                                                                 
    network = "default"                                                               
    access_config {                                                                   
      # Ephemeral ip                                                                  
    }                                                                                 
  }                                                                                   
                                                                                      
  metadata_startup_script = "${file("scripts/install-apache.sh")}"                    
                                                                                      
  #    provisioner "local-exec" {                                                     
  #        inline = [                                                                 
  #            "sudo /tmp/install-apache.sh"                                          
  #        ]                                                                          
  #    }                                                                              
                                                                                      
}                                                                                     
