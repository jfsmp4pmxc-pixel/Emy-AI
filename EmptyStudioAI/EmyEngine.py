import math
import random

def sigmoid(x):
    x = max(-500, min(500, x))
    return 1.0 / (1.0 + math.exp(-x))

def sigmoid_derivative(x):
    return x * (1.0 - x)

class AdvancedMathAI:
    def __init__(self):
        random.seed(101)
        self.W1 = [[random.uniform(-0.5, 0.5) for _ in range(16)] for _ in range(2)]
        self.W2 = [random.uniform(-0.5, 0.5) for _ in range(16)]
        self.b1 = [0.0] * 16
        self.b2 = 0.0
        self.MAX_VAL = 10.0
        self.auto_train()

    def forward(self, X):
        X_scaled = [X[0] / self.MAX_VAL, X[1] / self.MAX_VAL]
        self.hidden_inputs = [0.0] * 16
        for j in range(16):
            sum_val = 0.0
            for i in range(2):
                sum_val += X_scaled[i] * self.W1[i][j]
            self.hidden_inputs[j] = sigmoid(sum_val + self.b1[j])
            
        output_sum = sum(self.hidden_inputs[j] * self.W2[j] for j in range(16)) + self.b2
        self.output = sigmoid(output_sum + self.b2)
        return self.output

    def auto_train(self):
        X_homework = [
            [0, 1], [1, 1], [2, 1], [1, 3], [3, 2], [3, 3],
            [4, 3], [5, 2], [2, 6], [4, 5], [7, 2], [5, 5]
        ]
        y_homework = [(x[0] + x[1]) / self.MAX_VAL for x in X_homework]
        
        for epoch in range(3500):
            for X, y in zip(X_homework, y_homework):
                X_scaled = [X[0] / self.MAX_VAL, X[1] / self.MAX_VAL]
                h_inputs = [0.0] * 16
                for j in range(16):
                    s = X_scaled[0] * self.W1[0][j] + X_scaled[1] * self.W1[1][j]
                    h_inputs[j] = sigmoid(s + self.b1[j])
                
                o_sum = sum(h_inputs[j] * self.W2[j] for j in range(16)) + self.b2
                pred = sigmoid(o_sum)
                
                delta_out = (y - pred) * sigmoid_derivative(pred)
                delta_hidden = [0.0] * 16
                for j in range(16):
                    delta_hidden[j] = delta_out * self.W2[j] * sigmoid_derivative(h_inputs[j])
                
                for j in range(16):
                    self.W2[j] += 0.25 * delta_out * h_inputs[j]
                self.b2 += 0.25 * delta_out
                
                for i in range(2):
                    for j in range(16):
                        self.W1[i][j] += 0.25 * delta_hidden[j] * X_scaled[i]
                for j in range(16):
                    self.b1[j] += 0.25 * delta_hidden[j]