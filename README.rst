=========
 duckdns
=========

---------------------------------------------
A DuckDNS ip updater program
---------------------------------------------

:Author: Manuel Domínguez López <mdomlop@gmail.com>
:Date:   2019-05-08
:Copyright: GPLv3
:Version: 1.1
:Manual section: 1
:Manual group: network tools


SYNOPSIS
========

``duckdns``

DESCRIPTION
===========

DuckDNS is a free service which will point a DNS (sub domains of duckdns.org)
to an IP of your choice

When you run ``duckdns`` without options it will read the default
configuration files in ``/etc/duckdns.d/*.cfg`` and then it will update
the ip's associated.

You must add a cfg file for every domain registered in duckdns.org. For example:

::

        $ cat /etc/duckdns.d/example.cfg
        duckdns_hostname=example
        duckdns_token=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX

Every configuration file in ``/etc/duckdns.d/`` must end in ``.cfg``.


SYSTEMD
=======

A systemd timer was provided for execute in daemon mode. Just start
and enable ``duckdns.timer``.

By default every 5 minutes the ip's will be update in server. You can change
such frecuency editing ``OnUnitActiveSec`` value with:

::

        systemctl edit duckdns.timer

FILES
=====

**/usr/bin/duckdns**
    The executable script executed by service.

**/usr/lib/systemd/system/duckdns.service**
    The service associated to timer.

**/usr/lib/systemd/system/duckdns.timer**
    The systemd timer.

**/etc/duckdns.d/default.cfg**
   Example configuration file with empty fields. Edit at convenience or remove
   it.

BUGS
====

Probably. If you found any let me know, please.


SEE ALSO
========

systemd.unit(5) systemd.timer(5)
