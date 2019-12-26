# Spring Boot 项目通用 CI 脚本

## 使用

1. 创建 submodule
    ```
    git submodule add -b master -f ../../../ship/seaman.git .gitlab/seaman
    ```
    ../../../ship/seaman.git 为 seaman 的相对当前项目的路径
    上面命令在 .gitlab/seaman 目录下创建了项目 git@code.tooc.in:ship/seaman.git 的 submodule 并指定分支为 master

2. 创建 .gitlab-ci.yml
    ```yml
    include:
      - project: 'ship/seaman'
        ref: master
        file: '/spring-boot/main.gitlab-ci.yml'
    ```

3. 配置参数(非必须)

    在 include 下面定义 variables 可覆盖默认参数配置
    ```yml
    variables:
      # Docker 仓库地址
      REPOSITORY_BASE: 'registry.cn-hangzhou.aliyuncs.com/mastertooc'
      # 本项目 sprint-boot 文件夹相对于主工程位置
      BUILD_SCRIPTS_DIR: .gitlab/seaman/spring-boot
      # settings-docker 位置
      SETTINGS_DOCKER_FILE: $BUILD_SCRIPTS_DIR/settings-docker.xml
      # Dockerfile 位置
      DOCKERFILE: $BUILD_SCRIPTS_DIR/Dockerfile
      # deployment 文件位置
      DEPLOYMENT_FILE: $BUILD_SCRIPTS_DIR/deployment.yaml
      REPLICAS_NUM: 1
      REQUESTS_CPU: '0.01'
      LIMITS_CPU: '1.5'
    ```

    对于 DEPLOYMENT_FILE REPLICAS_NUM REQUESTS_CPU LIMITS_CPU 可以加前缀 DEBUG_ DEV_ ALPHA_ RELEASE_ 分别指定不同环境的配置
    ```yml
    variables:
      DEBUG_DEPLOYMENT_FILE: $BUILD_SCRIPTS_DIR/deployment.yaml
      DEV_REPLICAS_NUM: 1
      RELEASE_REQUESTS_CPU: '0.01'
      ALPHA_LIMITS_CPU: '1.5'
    ```

## 更新

1. 更新 seaman submodule

    ```
    git submodule update --remote
    ```

    如果有更新的话执行 `git status` 应该能看到 submodule 改变

    ```
    modified:   .gitlab/seaman (new commits)
    ```

2. 提交 submodule 改变

## 使用不同的 seaman 分支

修改 .gitmodules 里的 branch 和 .gitlab-ci.yml 里 include 的 ref，这两个必须一致

## Docker 镜像命名规则

`$REPOSITORY_BASE/$CI_PROJECT_NAME:$CI_COMMIT_SHA-$buildType`

例如:

```
registry.cn-hangzhou.aliyuncs.com/mastertooc/cortex:7108d218928f1b2c96476bd15ff162791896975f-dev
```

## 参考

https://spring.io/guides/gs/spring-boot-docker/

https://medium.com/@shrikarvk/creating-a-docker-container-for-spring-boot-app-d5ff1050c14f

https://github.com/spotify/dockerfile-maven

https://docs.gitlab.com/ee/ci/git_submodules.html

https://gitlab.com/gitlab-org/gitlab-ci-yml/blob/master/Maven.gitlab-ci.yml

https://gitlab.com/gitlab-org/gitlab-ce/blob/master/.gitlab-ci.yml

https://stackoverflow.com/questions/1777854/how-can-i-specify-a-branch-tag-when-adding-a-git-submodule