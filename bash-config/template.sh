function template {
    case $1 in
      *.htm|*.html )
        cat > $1 <<EOD
<!DOCTYPE html>
<html lang="en-GB">
    <head>
        <title>HTML Template</title>
        <link rel="stylesheet" type="text/css" media="all" href="style.css" />
        <script type="text/javascript" src="script.js"></script>
    </head>
    <body>
    </body>
</html>
EOD
        ;;
      *.py )
        cat > $1 <<EOD
#!/usr/bin/env python

if __name__ == '__main__':
    pass
EOD
        chmod 0755 $1 ;;
      * )
        echo "Error: no template of type $1 found"
    esac
}
