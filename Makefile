all: deploy

deploy:
	ansible-playbook -i hosts -c local deploy.yml -K

install:
	ansible-playbook -i hosts -c local install.yml

after_install:
	./after_install.sh
