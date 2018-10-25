FROM ubuntubase

# RUN /app/provision.sh prepare_install && \
#     /app/provision.sh install_deps && \
#     /app/provision.sh install_qtwebkit_deps && \
#     /app/provision.sh download_official_qt && \
#     /app/provision.sh install_official_qt && \
#     /app/provision.sh install_qtwebkit && \
#     /app/provision.sh install_pyqt5 && \
#     /app/provision.sh install_python_deps && \
#     /app/provision.sh install_flash && \
#     /app/provision.sh install_msfonts && \
#     /app/provision.sh install_extra_fonts && \
#     /app/provision.sh remove_builddeps && \
#     /app/provision.sh remove_extra

ADD docker/nginx /etc/nginx
ADD . /app
RUN pip install -i https://pypi.doubanio.com/simple --upgrade pip &&\
    pip install -e /app/slyd && \
    pip install -e /app/slybot
RUN python3 /app/portia_server/manage.py migrate

EXPOSE 9001
ENTRYPOINT ["/app/docker/entry"]
