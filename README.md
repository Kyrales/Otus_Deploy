### Запуск jenkins в контейнере

```bash
docker run -p 8080:8080 -p 50000:50000 -v ./jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk17
```

`build.jenkinsfile` - Пайплайн с прогоном тестов

`deploy.jenkinsfile` - Пайплайн со сборкой в тестовое окружение

`tools/deploy_test.os` - Скрипт сборки в тестовое окружение

`tools/baselist.json` - Список баз тестового окружения