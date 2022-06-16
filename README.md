# Домашнее задание к занятию "08.05 Тестирование Roles"

## Подготовка к выполнению
1. Установите molecule: `pip3 install "molecule==3.4.0"`
2. Соберите локальный образ на основе [Dockerfile](./Dockerfile)

## Основная часть

Наша основная цель - настроить тестирование наших ролей. Задача: сделать сценарии тестирования для vector. Ожидаемый результат: все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos7` внутри корневой директории clickhouse-role, посмотрите на вывод команды.
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.

Добавил дистрибутивы, получилось 3: centOS 7, CentOS 8, Ubuntu. Molecule test проходит без ошибок:

![image](https://user-images.githubusercontent.com/92969676/173748354-87aea3e4-296b-49b8-95ec-85b5d38c7733.png)

![image](https://user-images.githubusercontent.com/92969676/173748450-48a3c65e-6e96-442a-8867-983258a551f4.png)

![image](https://user-images.githubusercontent.com/92969676/173748635-6a800324-8e7e-45cf-a220-9327115fb238.png)

![image](https://user-images.githubusercontent.com/92969676/173747542-5afe8506-181f-47fc-b768-6d56af7e6769.png)

5. Добавьте несколько assert'ов в verify.yml файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска, etc). Запустите тестирование роли повторно и проверьте, что оно прошло успешно.

![image](https://user-images.githubusercontent.com/92969676/173856318-16ee0e77-a0db-430e-975f-ae8bff49f9a7.png)

6. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

Добавлен tag https://github.com/QuiteRunaWay/Ansible_role_test/tree/1.1.0

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example)

Сделано.

![image](https://user-images.githubusercontent.com/92969676/173859197-b69f9a5e-96cf-4789-ab54-808b661df255.png)

2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo - путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.

Процесс идёт очень долго (1 прогон (4 окружения) порядка 20-25 минут заняло):

![image](https://user-images.githubusercontent.com/92969676/173884479-03c9aae7-1a1f-491f-b3cd-d076cbcb1ee7.png)

![image](https://user-images.githubusercontent.com/92969676/173884794-3f4f8f67-324f-4e7a-b472-5b95de51532a.png)

![image](https://user-images.githubusercontent.com/92969676/173885536-4a726ec8-8d30-4f5d-96d4-bf058495c6b1.png)

но в итоге заканчивается успешно:

![image](https://user-images.githubusercontent.com/92969676/173886655-d0ae9cb5-5d3b-49aa-819b-2094d6602ce1.png)

4. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.

Создал облегченный сценарий для podman на основе стестирования python 3.7 против ansible 2.10.

5. Пропишите правильную команду в `tox.ini` для того чтобы запускался облегчённый сценарий.

Поменял файл tox.ini

![image](https://user-images.githubusercontent.com/92969676/174055407-fdfa4b39-1b83-4f80-a99d-1ac9bb9d6ccb.png)

6. Запустите команду `tox`. Убедитесь, что всё отработало успешно.

Отработало успешно:

![image](https://user-images.githubusercontent.com/92969676/174055287-13272dde-b078-4a55-b745-b2bfa4d94c71.png)


7. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Ссылка на репозиторий являются ответами на домашнее задание. Не забудьте указать в ответе теги решений Tox и Molecule заданий.

Сценарии для тестирования molecule разнес в разные директории: podman и docker. В зависимости от нужного тестирования драйвера в файле tox.ini в коменде прописываем через ключ ```-s``` нужный "драйвер", далее внести изменения в ```tox.ini` для нужного выбора ```requirements.txt```. В общем сделал как понял.

Для тестирования роли для docker:
Меняем в ```tox.ini``` {posargs:molecule test ```-s docker``` --destroy always}, и указываем параметр ```-r tox-requirements.txt```

Для тестирования роли для podman:
Меняем в ```tox.ini``` {posargs:molecule test ```-s podman``` --destroy always}, и указываем параметр ```-r tox1-requirements.txt```

Оба файла ```tox-requirements.txt.``` и ```tox1-requirements.txt.``` приложил в текущей директории.




