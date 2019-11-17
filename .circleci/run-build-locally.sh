curl --user ${CIRCLE_TOKEN}: \
    --request POST \
    --form revision=<コミットハッシュ>\
    --form config=@config.yml \
    --form notify=false \
        https://circleci.com/api/v1.1/project/github/keisuke713/tasks/tree/setting_circleci
