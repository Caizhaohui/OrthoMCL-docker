RUN_DIR=${1:-$PWD}

# Start MySQL
echo Starting MySQL container...
docker run --name orthomcl-mysql -e MYSQL_ROOT_PASSWORD=asdf1234 -e MYSQL_USER=orthomcl_user -e MYSQL_PASSWORD=shhh_this_is_secret -e MYSQL_DATABASE=orthomcl -d mysql | tee .ortho_mcl_db_container_id | head -n1

# Only keep container id in temporary file
echo `tail -n 1 .ortho_mcl_db_container_id` > .ortho_mcl_db_container_id

sleep 10

# Start OrthoMCL container
echo Starting OrthoMCL container...
echo Mounting local directory ${RUN_DIR} to /host_dir within the OrthoMCL container
docker run -it --rm --name orthomcl-run --link orthomcl-mysql:mysql -v ${RUN_DIR}:/host_dir granek/orthomcl /bin/bash

# Clean up after MySQL container
docker kill `cat .ortho_mcl_db_container_id`
docker rm `cat .ortho_mcl_db_container_id`
rm .ortho_mcl_db_container_id
