# CFResourceOptimizer
This project is to support DevOps pipeline for Bluemix / Cloud Foundry resource optimization.

It has few basic scripts which can be integrated with Jenkins or any CI tool to start and stop CF applications and Bluemix Containers in regular basis. For example, when Developers are not using Bluemix resources in Development environment all the resources can be shutdown.

Thus, it will greatly reduce the usage cost of the Bluemix account. Note, scripts should be modified according to specific requirement. You are free to do so. Cheers :)

# login2Blmx.sh  

This script takes login credential and target account, org and space information to log into Bluemix or any CF account.

Arguments : username organisation space account apikey

Example: ./login2Blmx.sh me@dhrubo.in TestOrg TestSpace 3d20d8erfb5c3603873ab212b867sj79 syonGHKG8zBOKV3LxCx3A020jncTJ-21jvxas4gsd9aI

# startResources.sh  &  stopResources.sh

This script takes login credential and target account, org and space information to log into Bluemix or any CF account and change the workspace to the given space and execute either start or stop resource commands of CF applications and Bluemix containers available within the space. This script can run stand alone. 

Arguments : username organisation space account apikey

Example: ./startResources.sh me@dhrubo.in TestOrg TestSpace 3d20d8erfb5c3603873ab212b867sj79 syonGHKG8zBOKV3LxCx3A020jncTJ-21jvxas4gsd9aI
Example: ./stopResources.sh me@dhrubo.in TestOrg TestSpace 3d20d8erfb5c3603873ab212b867sj79 syonGHKG8zBOKV3LxCx3A020jncTJ-21jvxas4gsd9aI

# startCFApps.sh & stopCFApps.sh  

This script takes CF/Bluemix space in its argument and change the target space to the given space and execute either start or stop commands of CF applications available within the space. Running login2Blmx.sh is pre-requisite.

Arguments : space

Example: ./startCFApps.sh TestSpace 
Example: ./stopCFApps.sh TestSpace 

# startContainers.sh & stopContainers.sh  

This script takes CF/Bluemix space in its argument and change the target space to the given space and execute either start or stop commands of Bluemix containers available within the space. Running login2Blmx.sh is pre-requisite.

Arguments : space

Example: ./startContainers.sh TestSpace 
Example: ./stopContainers.sh TestSpace

# scanContainers.sh

This script scan all the container images in Bluemix registry one by one and if finds any CRITICAL flag , it further inspects the image for more finer detail. This scripts needs to be executed after ./login2Blmx.sh  

Arguments : none

Example: ./scanContainers.sh
