### ec2_system_stats.sh

Simple script that I personally use on an ec2 instance hosting my webserver

----

Oneliner

```
wget https://raw.githubusercontent.com/v-filip/ec2_system_stats.sh/main/ec2_system_stats.sh &> /dev/null ; sudo chmod +x ec2_system_stats.sh ; ./ec2_system_stats.sh --verbose
```

----

#### Usage 

*Install*
```
wget https://raw.githubusercontent.com/v-filip/ec2_system_stats.sh/main/ec2_system_stats.sh &> /dev/null ; chmod +x ec2_system_stats.sh ; ./ec2_system_stats.sh --install
```

<br>

*Uninstall*

```
wget https://raw.githubusercontent.com/v-filip/ec2_system_stats.sh/main/ec2_system_stats.sh &> /dev/null ; chmod +x ec2_system_stats.sh ; ./ec2_system_stats.sh --uninstall
```

<br>

*Help*
```
./ec2_system_stats.sh --h [OR]

~/.scripts ❯ ./ec2_system_stats.sh --help [OR]

~/.scripts ❯ ./ec2_system_stats.sh help

    -v --verbose
        Prints more info!
    -i --install
        Installs the script for future use
    -u --uninstall
        Uninstalls the script
```

<br>

*Standard*

![pic1](https://github.com/v-filip/ec2_system_stats.sh/blob/main/example_img_base_v3.png)

<br>

*Verbose*

![pic1](https://github.com/v-filip/ec2_system_stats.sh/blob/main/example_img_verbose_v3.png)
