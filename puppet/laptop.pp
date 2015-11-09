package { 'emacs23' :
    ensure => present,
}

package { 'openjdk-6-jdk':
    ensure => present,
}

package { 'maven2':
    ensure => present,
}

package { 'ant1.7':
    ensure => present,
}

package { 'groovy':
    ensure => present,
}

package { 'gradle':
    ensure => present,
}

package { 'mercurial':
    ensure => present,
}

package { 'subversion':
    ensure => present,
}

package { 'swi-prolog-nox':
    ensure => present,
}

package { 'vnc4server':
    ensure => present,  
}

package { 'mysql-server-core-5.5':
    ensure => present,
}

package { 'git':
    ensure => present,
}

package { 'mono-runtime':
    ensure => present,
}

package { 'mono-xbuild':
    ensure => present,
}

package { 'mono-gmcs':
    ensure => present,
}