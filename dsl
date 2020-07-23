job("job1") {

		description()

		keepDependencies(false)

		scm {

			git {

				remote {

					github("rintucmathew/mlopsdevopsal1", "https")

				}

				branch("*/master")

			}

		}

		disabled(false)

		concurrentBuild(false)

		steps {

			shell("scp * /root/code1")

		}

	}

	

	job("job2") {

		description()

		keepDependencies(false)

		disabled(false)

		concurrentBuild(false)

		steps {

			shell("""

	cd /root/code1

	if ls | grep py

	then

	docker run -dit --name keras\$BUILD_NUMBER rintucmathew/jenkins:v1

	elif ls | grep html

	then

	docker run -dit -p 81:80 -v /root/code1:/var/www/html --name http\$BUILD_NUMBER http:latest

	else

	echo unknownfile

	fi

	""")

		}

	}

	job("job3") {

		description()

		keepDependencies(false)

		disabled(false)

		concurrentBuild(false)

		steps {

			shell("""status=\$(curl -o /dev/null -s -w "%{http_code}" 192.168.99.101:81)

	if [ \$status == 200 ]

	then 

	echo good

	else

	curl -u admin:admin http://192.168.99.101:8080/job/mail_job4/build?token=rintu

	fi""")

		}

	}

	job("job4") {

		description()

		keepDependencies(false)

		disabled(false)

		concurrentBuild(false)

		publishers {

			mailer("rintucmathew1998@gmail.com", false, false)

		}

	}

	job("job5") {

		description()

		keepDependencies(false)

		disabled(false)

		concurrentBuild(false)

		steps {

			shell("curl -u admin:rintu http://192.168.99.101:8080/job/interpreter_job2/build?token=rintu")

		}


