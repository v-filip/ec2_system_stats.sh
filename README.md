### ec2_system_stats.sh

Simple script that I personally use on an ec2 instance hosting my webserver

----

Oneliner

```
wget https://raw.githubusercontent.com/v-filip/ec2_system_stats.sh/main/ec2_system_stats.sh ; sudo chmod +x ec2_system_stats.sh ; ./ec2_system_stats.sh --verbose
```

----

#### Usage 

*Install*
```
wget https://raw.githubusercontent.com/v-filip/ec2_system_stats.sh/main/ec2_system_stats.sh ; chmod +x ec2_system_stats.sh ; ./ec2_system_stats.sh --install
```

<br>

*Uninstall*

```
wget https://raw.githubusercontent.com/v-filip/ec2_system_stats.sh/main/ec2_system_stats.sh ; chmod +x ec2_system_stats.sh ; ./ec2_system_stats.sh --uninstall
```

<br>

*Help*
```
./ec2_system_stats.sh --h [OR]

~/.scripts ❯ ./ec2_system_stats.sh --help [OR]

~/.scripts ❯ ./ec2_system_stats.sh help

-v --verbose

    Prints more info!
```

<br>

*Standard*

![pic1](https://github.com/v-filip/ec2_system_stats.sh/blob/main/example_img_base_v2.png)

<br>

*Verbose*

![pic1](https://github.com/v-filip/ec2_system_stats.sh/blob/main/example_img_verbose_v2.png)
