```bash
sudo openresty -p /home/nghia/vnuid-gateway -c conf/nginx.conf
sudo openresty -p /home/nghia/vnuid-gateway -c conf/nginx.conf -s reload
sudo ss -tulnp | grep :80
```