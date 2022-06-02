Lighthouse-role
=========

Роль устанавливает на ваш хост Lighthouse

Requirements
------------

Особых требований не предъявляется.

Role Variables
--------------

Роль устанавливается из под пользователя с правами root. При необходимости данный параметр можно поменять в переменной в разделе vars.

Дистрибутив выкачивается по ссылке: `http://github.com/VKCOM/lighthouse.git`

Dependencies
------------

По умолчанию Вам необходимо иметь на своем хосте установленный nginx.
Вы можете воспользоваться установкой nginx с playbook расположенного по ссылке `https://github.com/QuiteRunaWay/Ansible_2/tree/main/playbook`

Так же необходимо для работы с репозиторием с дистрибутивом, иметь заранее установленный git.

Example Playbook
----------------

пример установки роли:

hosts: your_hostname
  roles: 
    - lighthouse-role


Пример установки с зависимостью git:

hosts: your_hostname
  pre_tasks:
    - name: lighthouse | install dependencies
      become: true
      ansible.builtin.yum:
        name: git
        state: present  
  roles: 
    - lighthouse-role

License
-------

BSD