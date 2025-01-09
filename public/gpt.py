import pynvim
from transformers import AutoModelForCausalLM, AutoTokenizer

@pynvim.plugin
class GPTPlugin:
    def __init__(self, nvim):
        self.nvim = nvim
        self.tokenizer = AutoTokenizer.from_pretrained("gpt2")
        self.model = AutoModelForCausalLM.from_pretrained("gpt2")

    @pynvim.command('GPTComplete', nargs='*', range='')
    def gpt_complete(self, args, range):
        prompt = " ".join(args)
        inputs = self.tokenizer(prompt, return_tensors="pt")
        outputs = self.model.generate(inputs['input_ids'], max_length=50)
        response = self.tokenizer.decode(outputs[0])
        self.nvim.out_write(response + "\n")
