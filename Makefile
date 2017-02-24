all: deploy

deploy:
	ansible-playbook -i hosts -c local deploy.yml

install:
	ansible-playbook -i hosts -c local install.yml

after_install:
	./after_install.sh
