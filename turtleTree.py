import turtle

pistachio = turtle.Turtle() 
pistachio.left(90)

def drawTree(length): #can add angle to this too 
    # base case
    if length < 2: #tree length too short
        pistachio.dot(20, "dark green") #draw leaf 
    #call to itself in a reduced problem
    else:
         # 1. draw a stick of a certain length
        pistachio.forward(length)
        # 2. Grow 2 branches at different angles
        # 2A. Turn right at some angle
        pistachio.right(40)
        # 2B. Call itself to draw Tree
        drawTree(length - 10) #you can also + - * and also then can add angle parameters 
        # 2C. Turn left by 2*angle
        pistachio.left(80) 
        # Call itself to draw Tree
        drawTree(length - 10)
        # Turn right by some angle
        pistachio.right(40) 
        # Walk backwards lengthwise
        pistachio.backward(length)
        


drawTree(50)

