#! /bin/bash

password="Apple-Banana-9"

for username in $(cat students.csv | tail -n +2); do
  aws iam update-login-profile --user-name "${username}" --password "${password}" --password-reset-required
done
