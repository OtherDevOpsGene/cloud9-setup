#! /bin/bash

# Usage:
#   bash list-accounts.sh > index.html 2>/dev/null
#   aws s3 cp index.html s3://cloud9.otherdevopsgene.dev/index.html --acl public-read
# Page is at https://s3.us-east-2.amazonaws.com/cloud9.otherdevopsgene.dev/index.html


declare -A urls passwords

# Read Cloud9 URLs by username
while IFS="=" read -r key value
do
  urls[$key]="$value"
done < <(terraform output --json cloud9_urls | jq -r 'to_entries|map("\(.key)=\(.value)")|.[]')

# Read encyrpted passwords by username
while IFS="=" read -r key value
do
  passwords[$key]="$value"
done < <(terraform output --json passwords | jq -r 'to_entries|map("\(.key)=\(.value)")|.[]')

class=$(terraform output -raw class_name)

cat <<HEAD
<html>
  <head>
    <title>$class</title>
    <style>
      table {
        border:1px solid #b3adad;
        border-collapse:collapse;
        padding:5px;
      }
      table th {
        border:1px solid #b3adad;
        padding:5px;
        background: black;
        color: white;
      }
      table td {
        border:1px solid #b3adad;
        text-align:left;
        padding:5px;
        background: #ffffff;
        color: #313030;
      }
      .password {
        font-family: monospace;
      }
      tr.even td {
        background: #f0f0f0;
        color: #313030;
      }
    </style>
    </head>
  <body>
    <h1>$class</h1>

    <p>Log in at <a href="https://732829343588.signin.aws.amazon.com/console">https://732829343588.signin.aws.amazon.com/console</a>.</p>

    <p>Or, go directly to your Cloud9 environment using the URL:</p>
    
    <table>
      <thead>
        <tr>
          <th>Username</th>
          <th>Password</th>
          <th>Cloud9 URL</th>
        </tr>
      </thead>
      <tbody>
HEAD

num=0
# for each username
for k in "${!urls[@]}"
do
  let num++
  row=$( [[ $(($num % 2)) -eq 0 ]] && echo "even" || echo "odd")

  # base64 decode and then GPG decrypt the password
  decrypted=$(echo "${passwords[$k]}" | base64 -d | gpg -d)
  encoded=$(echo "$decrypted" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
  echo "<tr class=\"$row\"><td>$k</td><td class=\"password\">$encoded</td><td><a href=\"${urls[$k]}\">${urls[$k]}</a></td></tr>"
done

cat <<-FOOT
      </tbody>
    </table>

    <p>If you are asked for the Account ID, use <strong>732829343588</strong>.

  </body>
</html>
FOOT
