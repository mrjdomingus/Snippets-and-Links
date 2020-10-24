# Copy zip file to gitea and postgresql container

# In gitea container
unzip gitea-dump-1482906742.zip
cd gitea-dump-1482906742

mv app.ini /data/gitea/conf/app.ini
mv data/* /data/gitea
mv log/* /data/gitea

mv repos/* /data/git/repositories
chown -R git:git /data/gitea/conf/app.ini /data/git/repositories/

# In db container
# unzip zip file
psql -d gitea -U gitea -f gitea-db.sql

# in gitea container
/app/gitea/gitea web # or restart container(s)
