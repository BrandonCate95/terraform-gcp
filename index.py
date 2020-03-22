import fileinput

filename = "./gcp-create-gcs/main.tf"

values = {
    "startup_script": """sudo apt-get update; 
                        sudo apt-get install nginx -y;"""
}

file = fileinput.FileInput(filename, inplace=True, backup='.bak')

for line in file:
    for key in values:
        print(
            line.replace("${{" + key + "}}",values[key])
        )

file.close()

# with fileinput.FileInput(filename, inplace=True, backup='.bak') as file:
#     for line in file:
#         for key in values:
#             print(
#                 line.replace("${{" + key + "}}", values[key], end='')
#             )