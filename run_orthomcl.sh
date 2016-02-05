RUN_DIR=${1:-$PWD}

# Start MySQL
echo Starting MySQL container...
docker run --name orthomcl-mysql -e MYSQL_ROOT_PASSWORD=asdf1234 -e MYSQL_USER=orthomcl_user -e MYSQL_PASSWORD=shhh_this_is_secret -e MYSQL_DATABASE=orthomcl -d mysql | head -n1

sleep 2

# Start OrthoMCL container
echo Starting OrthoMCL container...
echo Mounting local directory ${RUN_DIR} to /host_dir within the OrthoMCL container
echo ""
echo "To suspend your OrthoMCL session use Ctrl-p + Ctrl-q"
echo "To resume run: docker attach orthomcl-run"
echo "Then hit the enter/return key to get a prompt"
echo ""

docker run -it --name orthomcl-run --link orthomcl-mysql:mysql -v ${RUN_DIR}:/host_dir granek/orthomcl /bin/bash

echo "Leaving MySQL container and OrthoMCL container intact"
echo ""
echo "To clean up containers run:"
echo "docker stop orthomcl-mysql; docker rm orthomcl-run orthomcl-mysql"
echo ""
echo "To continue working in the OrthoMCL container run:"
echo "docker attach orthomcl-run"
echo "Then hit the enter/return key to get a prompt"
echo ""
echo "If you used exit to leave the OrthoMCL session, resume by running:"
echo "docker start orthomcl-run; docker attach orthomcl-run"

