
** download videos maiores que 100MB **

cd public/video/
wget --timeout=1 https://dms.ufpel.edu.br/static/videos/apresentacao_surtos_epidemias_1080p.mp4
wget --timeout=1 https://dms.ufpel.edu.br/static/videos/investigacao_surtos_aula_1_1080p.mp4
wget --timeout=1 https://dms.ufpel.edu.br/static/videos/investigacao_surtos_aula_2_1080p.mp4
wget --timeout=1 https://dms.ufpel.edu.br/static/videos/investigacao_surtos_aula_3_1080p.mp4
wget --timeout=1 https://dms.ufpel.edu.br/static/videos/apresentacao_surtos_epidemias_720p.mp4
wget --timeout=1 https://dms.ufpel.edu.br/static/videos/investigacao_surtos_aula_1_720p.mp4
wget --timeout=1 https://dms.ufpel.edu.br/static/videos/investigacao_surtos_aula_2_720p.mp4
wget --timeout=1 https://dms.ufpel.edu.br/static/videos/investigacao_surtos_aula_3_720p.mp4

**run**

docker-compose up --remove-orphans

**test**

> http://localhost:21509/modulos/63758ed55ebc0215731f6c36


> mongo mongodb://mamongo:mamongo@127.0.1.1:27017/admin?authSource=admin