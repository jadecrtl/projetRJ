for procedure in ps*.sql
do
	sudo mysql -u root < $procedure
done
