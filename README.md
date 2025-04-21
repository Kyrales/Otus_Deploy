### Актуальное видео Открытого урока
https://www.youtube.com/watch?v=uD6qURLFJ9o&list=PLfnFOImnyWRUSVNtDVIPGlG9Dag6gnDtj

### Плагины для Jenkins
Allure
Copy Artifact


### Запуск jenkins в контейнере

```bash
docker run -p 8080:8080 -p 50000:50000 -v ./jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk17
```

### Описание настроек

`build.jenkinsfile` - Пайплайн с прогоном тестов

`deploy.jenkinsfile` - Пайплайн со сборкой в тестовое окружение

`tools/deploy_test.os` - Скрипт сборки в тестовое окружение

`tools/baselist.json` - Список баз тестового окружения
