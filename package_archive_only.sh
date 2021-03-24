#!/bin/sh

# 使用方法:
# step1: 将该脚本放在工程的根目录下（跟.xcworkspace文件or .xcodeproj文件同目录）
# step2: 根据情况修改下面的参数
# step3: 打开终端，执行脚本。（输入sh ，然后将脚本文件拉到终端，会生成文件路径，然后enter就可）

# =============项目自定义部分(自定义好下列参数后再执行该脚本)=================== #

# 是否编译工作空间 (例:若是用Cocopods管理的.xcworkspace项目,赋值true;用Xcode默认创建的.xcodeproj,赋值false)
is_workspace="true"

# .xcworkspace的名字，如果is_workspace为true，则必须填。否则可不填
workspace_name="HKDoctor"

# .xcodeproj的名字，如果is_workspace为false，则必须填。否则可不填
project_name="HKDoctor"

# 指定项目的scheme名称（也就是工程的target名称），必填
scheme_name="HKDoctor"

# 指定要打包编译的方式 : Release,Debug。一般用Release。必填
build_configuration="Release"

# method，打包的方式。方式分别为 development, ad-hoc, app-store, enterprise 。必填
method="development"


#  下面两个参数只是在手动指定Pofile文件的时候用到，如果使用Xcode自动管理Profile,直接留空就好
# (跟method对应的)mobileprovision文件名，需要先双击安装.mobileprovision文件.手动管理Profile时必填
mobileprovision_name="MMDoc_Doc_Dev"

# 项目的bundleID，手动管理Profile时必填
bundle_identifier="com.ump.company.Doctor"


echo "--------------------脚本配置参数检查--------------------"
echo "\033[33;1mis_workspace=${is_workspace} "
echo "workspace_name=${workspace_name}"
echo "project_name=${project_name}"
echo "scheme_name=${scheme_name}"
echo "build_configuration=${build_configuration}"
echo "bundle_identifier=${bundle_identifier}"
echo "method=${method}"
echo "mobileprovision_name=${mobileprovision_name} \033[0m"


# =======================脚本的一些固定参数定义(无特殊情况不用修改)====================== #

# 获取当前脚本所在目录
script_dir="$( cd "$( dirname "$0"  )" && pwd  )"
# 工程根目录
project_dir=$script_dir

# 时间
DATE=`date '+%Y%m%d_%H%M%S'`
# 指定输出导出文件夹路径
export_path="$project_dir/../Package/$scheme_name-$DATE"
# 指定输出归档文件路径
export_archive_path="$export_path/$scheme_name.xcarchive"
# 指定输出ipa文件夹路径
export_ipa_path="$export_path"
# 指定输出ipa名称
ipa_name="${scheme_name}_${DATE}"
# 指定导出ipa包需要用到的plist配置文件的路径
export_options_plist_path="$project_dir/ExportOptions.plist"


echo "--------------------脚本固定参数检查--------------------"
echo "\033[33;1mproject_dir=${project_dir}"
echo "DATE=${DATE}"
echo "export_path=${export_path}"
echo "export_archive_path=${export_archive_path}"
echo "export_ipa_path=${export_ipa_path}"
echo "export_options_plist_path=${export_options_plist_path}"
echo "ipa_name=${ipa_name} \033[0m"

# =======================自动打包部分(无特殊情况不用修改)====================== #

echo "------------------------------------------------------"
echo "\033[32m开始构建项目  \033[0m"
# 进入项目工程目录
cd ${project_dir}

# 指定输出文件目录不存在则创建
if [ -d "$export_path" ] ; then
    echo $export_path
else
    mkdir -pv $export_path
fi

# 判断编译的项目类型是workspace还是project
if $is_workspace ; then
# 编译前清理工程
xcodebuild clean -workspace ${workspace_name}.xcworkspace \
                 -scheme ${scheme_name} \
                 -configuration ${build_configuration}

xcodebuild archive -workspace ${workspace_name}.xcworkspace \
                   -scheme ${scheme_name} \
                   -configuration ${build_configuration} \
                   -archivePath ${export_archive_path}
else
# 编译前清理工程
xcodebuild clean -project ${project_name}.xcodeproj \
                 -scheme ${scheme_name} \
                 -configuration ${build_configuration}

xcodebuild archive -project ${project_name}.xcodeproj \
                   -scheme ${scheme_name} \
                   -configuration ${build_configuration} \
                   -archivePath ${export_archive_path}
fi

#  检查是否构建成功
#  xcarchive 实际是一个文件夹不是一个文件所以使用 -d 判断
if [ -d "$export_archive_path" ] ; then
    echo "\033[32;1m项目构建成功" ;
fi
