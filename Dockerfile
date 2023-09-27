FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

# udevadm and /etc/udev/rules.d is assumed by the picoscope packages.
RUN : \
	&& apt-get update \
	&& apt-get -y install curl gnupg \
	&& curl -fsSL https://labs.picotech.com/Release.gpg.key | gpg --dearm > /usr/share/keyrings/picotech-release.gpg \
	&& echo "deb [signed-by=/usr/share/keyrings/picotech-release.gpg] https://labs.picotech.com/picoscope7/debian/ picoscope main" > /etc/apt/sources.list.d/picoscope7.list \
	&& apt-get update \
	&& mkdir -p /etc/udev/rules.d \
	&& ln -s /bin/true /bin/udevadm \
	&& apt-get -y install picoscope \
	&& rm /bin/udevadm

CMD ["/opt/picoscope/bin/picoscope"]
