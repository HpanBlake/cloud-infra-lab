import boto3
from botocore.exceptions import BotoCoreError, ClientError, NoCredentialsError


def list_ec2_instances():
    try:
        ec2 = boto3.client("ec2", region_name="us-east-1")
        response = ec2.describe_instances()

        print("EC2 Instances:")
        found = False

        for reservation in response.get("Reservations", []):
            for instance in reservation.get("Instances", []):
                found = True
                instance_id = instance.get("InstanceId", "N/A")
                state = instance.get("State", {}).get("Name", "N/A")
                instance_type = instance.get("InstanceType", "N/A")
                print(f"Instance ID: {instance_id}")
                print(f"State: {state}")
                print(f"Type: {instance_type}")
                print("-" * 30)

        if not found:
            print("No EC2 instances found in this region.")

    except NoCredentialsError:
        print("AWS credentials not found. Please configure AWS CLI credentials first.")
    except (BotoCoreError, ClientError) as e:
        print(f"AWS error: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")


if __name__ == "__main__":
    list_ec2_instances()