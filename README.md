# Project 3 — Docker (End-to-End Container + Kubernetes Extra Credit)

This project builds a lightweight Docker image that automatically:
- reads two text files inside the container
- computes word statistics
- detects the container’s IP address
- writes results to `/home/data/output/result.txt`
- prints the contents of `result.txt` to the console and exits

Extra credit: deploys **two replicas** using **Kubernetes (Docker Desktop)** and captures pod status output.

---

## ✅ Requirements Covered

**Docker container**
- Uses a lightweight base image (`python:3.11-slim`)
- Reads:
  - `/home/data/IF.txt`
  - `/home/data/AlwaysRememberUsThisWay.txt`
- Outputs:
  - total words in each file
  - grand total words
  - top 3 frequent words in `IF.txt`
  - top 3 frequent words in `AlwaysRememberUsThisWay.txt` after splitting contractions
  - container IP address
- Writes results to: `/home/data/output/result.txt`
- Prints `result.txt` to console when the container runs

**Extra credit**
- Kubernetes Deployment with **2 replicas**
- Command output saved using:
  - `kubectl get pods > kube_output.txt`
  - `cat kube_output.txt`

---

## 📁 Project Structure

```

project3-docker/
Dockerfile
scripts.py
project3-deployment.yaml        # (extra credit)
kube_output.txt                 # (extra credit output)
data/
IF.txt
AlwaysRememberUsThisWay.txt

````

---

## 🐳 Docker Instructions

### 1) Build the image
From the project folder:

```bash
docker build -t project3-docker:1 .
````

### 2) Run the container

```bash
docker run --rm project3-docker:1
```

This will print the content of `/home/data/output/result.txt` and then exit.

### 3) Save the image as a `.tar` (for submission)

Replace `YOURUSERNAME` with your email username:

```bash
docker save -o YOURUSERNAME.tar project3-docker:1
```

### 4) Load and run from a `.tar` (grader workflow)

```bash
docker load -i YOURUSERNAME.tar
docker run --rm project3-docker:1
```

---

## ⭐ Extra Credit — Kubernetes (Docker Desktop)

### 1) Enable Kubernetes in Docker Desktop

Docker Desktop → Settings/Preferences → **Kubernetes** → Enable Kubernetes

Verify:

```bash
kubectl config current-context
kubectl get nodes
```

### 2) Deploy 2 replicas

```bash
kubectl apply -f project3-deployment.yaml
kubectl get pods
kubectl get deploy project3-docker
```

### 3) Save pod status output (required)

```bash
kubectl get pods > kube_output.txt
cat kube_output.txt
```

### 4) View logs from both replicas

```bash
kubectl logs -l app=project3-docker --tail=50
```

### 5) Cleanup

```bash
kubectl delete -f project3-deployment.yaml
```

---

## 📝 Notes

* Contractions are handled by splitting on apostrophes (e.g., `don't → don t`, `I'm → I m`) before counting word frequencies for `AlwaysRememberUsThisWay.txt`.
* IP addresses may differ between Docker standalone runs and Kubernetes runs (both are normal).
