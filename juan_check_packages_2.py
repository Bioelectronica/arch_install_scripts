import subprocess

### Find packages that need installing
my_file = open("/home/saveguest/git-repos/arch_install_scripts/packages.txt","r")
packages_required = my_file.read()
packages_required_list = packages_required.split('\n')
packages_required_list.sort()

### Find packages that are installed on machine
packages_installed = subprocess.run(['pacman','-Qqe'],text=True, stdout=subprocess.PIPE).stdout.splitlines()

### Compare lists to find packages that require installing
need_installing = list(set(packages_required_list) - set(packages_installed))
need_installing.sort()

### output missing package list to .txt file
with open('packages_not_found.txt', 'w') as f:
    for package in need_installing:
        f.write('%s\n' % package)
    print("packages_not_found.txt written scuessfully")
f.close()
