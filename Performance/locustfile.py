from locust import HttpUser, TaskSet, task, between

class MonicaTasks(TaskSet):

    def on_start(self):
        # Called once for each simulated user
        self.login()

    def login(self):
        self.client.post("/login", {
            "email": "replace_with_email",
            "password": "replace_with_password"
        })

    @task(3)
    def dashboard(self):
        self.client.get("/dashboard")

    @task(1)
    def view_contacts(self):
        self.client.get("/people")

    @task(1)
    def view_journals(self):
        self.client.get("/journal")
class WebsiteUser(HttpUser):
    tasks = [MonicaTasks]
    wait_time = between(1, 5)  # Simulate user think time
