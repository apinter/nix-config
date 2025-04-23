import argparse
import base64
from jinja2 import Environment, FileSystemLoader

def print_help():
    help_text = """
    Usage: python example.py -t template.j2 -o output.txt --cftoken "$your_cloudflare_token"

    Options:
      -t, --template           Path to the Jinja2 template file (required)
      -o, --output             Path to save the rendered output file (required)
      --cftoken                The cloudflare token
      --glab_regcred           Glab registration credential in a base64 encoded format
      --vuls_s3_secret_key     The secret key for the vuls S3 bucket
      --foxpass_api_key        The API key for Foxpass
      --jira_postee_pw         Jira password for postee to create Jira bug tickets

    Example:
      Generate auth.json for podman:

        python main.py -t auth_json.j2 -o auth.json --glab_regcred c3VwZXJTZWNyZXRTcXVpcnJlbA==

      Generate Cloudflare secret for TLS:

        python main.py -t cf.j2 -o cf.secret --cftoken 1234abc

      Generate vuls secret for S3:
        
        python main.py -t vuls.j2 -o vuls.secret --vuls_s3_secret_key 12345566abccc

      Generate Foxpass secret for API key:

        python main.py -t foxpass.j2 -o foxpass.secret --foxpass_api_key 778899ddeeff

      Generate postee config:

        python main.py -t postee.j2 -o postee.secret --jira_postee_pw 1234567890abcdef

    """
    print(help_text)

def is_base64_encoded(data):
    try:
        base64.b64encode(base64.b64decode(data)) == data
        return True
    except Exception:
        return False

parser = argparse.ArgumentParser(add_help=False)
parser.add_argument("-h", "--help", action="store_true", help="Show help message")
parser.add_argument("-t", "--template", type=str, help="Path to the Jinja2 template file")
parser.add_argument("-o", "--output", type=str, help="Path to save the output file")
parser.add_argument("--cftoken", type=str, help="The cloudflare token")
parser.add_argument("--glab_regcred", type=str, help="Glab registration credential in base64 encoded format")
parser.add_argument("--vuls_s3_secret_key", type=str, help="The secret key for the vuls S3 bucket")
parser.add_argument("--foxpass_api_key", type=str, help="The API key for Foxpass")
parser.add_argument("--jira_postee_pw", type=str, help="Jira password for postee to create Jira bug tickets")

args = parser.parse_args()

if args.help:
    print_help()
    exit(0)

if not args.template or not args.output:
    print(print_help())
else:
    template_file = args.template
    output_file = args.output
    cftoken = args.cftoken 
    glab_regcred = args.glab_regcred
    vuls_s3_secret_key = args.vuls_s3_secret_key 
    foxpass_api_key = args.foxpass_api_key
    jira_postee_pw = args.jira_postee_pw

    if glab_regcred and not is_base64_encoded(glab_regcred):
        print("Error: The provided glab_regcred is not a valid base64 encoded string.")
        exit(1)

env = Environment(loader=FileSystemLoader("."))

try:
    template = env.get_template(template_file)
except Exception as e:
    print(f"Error loading template: {e}")
    exit(1)

rendered_content = template.render(glab_regcred=glab_regcred, vuls_s3_secret_key=vuls_s3_secret_key, foxpass_api_key=foxpass_api_key, cftoken=cftoken, jira_postee_pw=jira_postee_pw)

with open(output_file, "w") as f:
    f.write(rendered_content)

print(f"Rendered template saved to {output_file}")
