 #!/bin/bash
 apt install -y apache2-bin
sudo systemctl enable apache2-bin
sudo systemctl start apache2-bin
chmod +x /home/ubuntu/project/install_apache2.sh
