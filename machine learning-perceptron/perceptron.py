# -*- coding: utf-8 -*-
"""
Created on Sat Jun 03 06:46:39 2017
@author: Administrator
"""

import numpy as np
import matplotlib.pyplot as plt
class data:
    def __init__(self):
        self.x_pos = []
        self.y_pos = []
        self.x_neg = []
        self.y_neg = []
        self.x_comb=[]
        self.y_comb=[]
    def inputdata(self):
        notEnd = True
        while notEnd:
            choice = raw_input("please indicate(by input 1 or else 0) if current input example is positive")
            if choice == 1:
                self.x_pos.append(raw_input("please input data of X axis"))
                self.y_pos.append(raw_input("please input data of Y axis")) 
            else :
                self.x_neg.append(raw_input("please input data of X axis"))
                self.y_neg.append(raw_input("please input data of Y axis"))
            res = raw_input("You finished?(Y/N)")
            if res == 'Y':
                break
    def formatData(self):
#        self.x_pos = [9,8,6,8,7]
#        self.y_pos = [6,4,7,5,5]
#        self.x_neg = [0,2,1,4,3]
#        self.y_neg = [1,4,3,5,1]
        pos_length = int (np.asarray(self.x_pos).shape[0])
        neg_length = int (np.asarray(self.x_neg).shape[0])
        self.x_comb = np.hstack((self.x_pos,self.x_neg))
        self.y_comb = np.hstack((self.y_pos,self.y_neg))
        y_p = np.ones(pos_length)
        y_c = np.ones(neg_length)*-1
        y = np.hstack((y_p,y_c))
        return y
    def iniPlot(self,w,w2,b,title):
        #Default : set w and b to 0
        x = np.asarray([i for i in range(1,1000,2)]).astype('float')/100
        y = (w * x  + b)/w2
        plt.plot(x,y)
#        self.x_pos = [9,8,6,8,7]
#        self.y_pos = [6,4,7,5,5]
#        self.x_neg = [1,2,1,4,3]
#        self.y_neg = [1,4,3,5,1]
        xi= np.asarray(self.x_pos,dtype = 'float')
        yi= np.asarray(self.y_pos,dtype = 'float')
        plt.scatter(xi,yi,color = '#0000FF' , marker = 'o')
        xi= np.asarray(self.x_neg,dtype = 'float')
        yi= np.asarray(self.y_neg,dtype = 'float')
        plt.scatter(xi,yi,color = '#808080' , marker = '^')
        plt.title (title)
        plt.xlabel("X")
        plt.ylabel("y")
    
    def learn(self,y):
        w = 0
        w2 = 0
        b = 0
        lear = 1
        itera = 0
        i = 0
        #stochastic gradient descent
        while True:
                xi = self.x_comb[i]
                x2i = self.y_comb[i]
                yi = y[i]
                if yi*(w*xi+w2*x2i+b)<=0:
                    w = w + lear*xi*yi
                    w2 = w2 + lear*x2i*yi
                    b = b + lear*yi
                    i=0
                    itera = itera + 1
                    #raw_input( )
                i = i + 1
                if i > 9:
                    break
        result = [-w,w2,-b]   
        for i in range(int(self.x_comb.shape[0])):
            xi = self.x_comb[i]
            x2i = self.y_comb[i]
            yi = y[i]
            result.append(yi*(w*xi+w2*x2i+b))
        print "End at "+str(itera)+" turn of training"
        return result
dataset = data()
#dataset.inputdata()
dataset.iniPlot(0,1,0,"Initial plot of X vs Y")
y = dataset.formatData()
result = dataset.learn(y)
dataset.iniPlot(result[0],result[1],result[2],"Perceptron: Final plot of X vs Y")
print "The total Cost: "+ str(sum(result[3:]))