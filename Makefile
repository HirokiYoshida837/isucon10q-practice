

PROJECT_ROOT:=/home/isucon/isuumo/webapp
BUILD_DIR:=/home/isucon/isuumo/webapp/go
BIN_NAME:=isuumo


.PHONY: build
build:
	cd $(BUILD_DIR); \
	go build -o $(BIN_NAME)

.PHONY: deploy
deploy: build
	sudo systemctl restart nginx; \
	sudo systemctl restart mysql.service; \
	sudo systemctl restart isuumo.go.service


# .PHONY: gitpullmain
# gitpullmain:
# 	git fetch --all
# 	git reset --hard origin/main
# 	git pull origin main


# # make gitpull BRANCH=
# .PHONY: gitpull
# gitpullmain:
# 	git fetch --all
# 	git checkout ${BRANCH}


.PHONY: bench
bench:
	cd /home/isucon/isuumo/bench ;\
	./bench -target-url http://127.0.0.1
