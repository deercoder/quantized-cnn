# This Makefile requires ATLAS and OpenVML in the compilation

CC=g++
MKDIR=mkdir -p
RM=rm -rf
SRC_DIR=src
OBJ_DIR=obj
BIN_DIR=bin
SRCS=$(wildcard $(SRC_DIR)/*.cc)
OBJS=$(SRCS:$(SRC_DIR)/%.cc=$(OBJ_DIR)/%.o)
CPPFLAGS=-I/usr/include/atlas -I/usr/local/OpenVML/include
CFLAGS=-Wall -std=c++11 -O2
LDFLAGS=-L/usr/lib64/atlas -L/usr/local/OpenVML/lib
LDLIBS= -latlas -lopenvml
DFLAGS=-D ENABLE_ATLAS -D ENABLE_OPENVML
TARGET=$(BIN_DIR)/QuanCNN

.PHONY: all run clean

all: $(BIN_DIR) $(OBJ_DIR) $(TARGET)

$(BIN_DIR):
	$(MKDIR) $(BIN_DIR)
$(OBJ_DIR):
	$(MKDIR) $(OBJ_DIR)
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cc
	$(CC) $(CPPFLAGS) $(CFLAGS) $(DFLAGS) -c $< -o $@

run:
	$(TARGET)

clean:
	$(RM) $(BIN_DIR) $(OBJ_DIR) $(OBJS) $(TARGET)
