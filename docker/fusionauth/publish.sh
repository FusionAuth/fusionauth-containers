
echo "version=${1}" > release-trigger

if [[ ${2} == "false" ]]; then
  echo "version=${1}" >> release-trigger-latest
fi

#git add .
#git commit -m"trigger GitHub action docker-publish for ${1}"
#git push
