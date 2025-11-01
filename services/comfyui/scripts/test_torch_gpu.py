# services/comfyui/scripts/test_torch_gpu.py
import torch, sys
print("torch:", getattr(torch, "__version__", "n/a"))
print("cuda available:", torch.cuda.is_available())
if torch.cuda.is_available():
    print("cuda version:", torch.version.cuda)
    print("device count:", torch.cuda.device_count())
    for i in range(torch.cuda.device_count()):
        print(i, torch.cuda.get_device_name(i))
else:
    print("No CUDA devices visible.")
sys.exit(0 if torch.cuda.is_available() else 2)
