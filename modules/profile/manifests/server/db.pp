# DB server
class profile::server-db {
	include mysql

	class { 'automysqlbackup':
		backup_dir          => '/var/backup',
	}
	automysqlbackup::backup { 'mysql':
		mysql_dump_username => 'root',
		mysql_dump_password => '',
		db_exclude          => ['performance_schema', 'information_schema'],
		table_exclude       => ['mysql.event'],
	}
}
