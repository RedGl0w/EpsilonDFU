CXX           = $(shell fltk-config --cxx)
INCLUDE       = include
CXXFLAGS      =  -Wall -Wextra $(addprefix -I,$(INCLUDE))
LD            = $(CXX)
LDFLAGS       =
BUILD_FOLDER  = ./output
OBJ_DIR       = $(BUILD_FOLDER)/objects
TARGET        = $(BUILD_FOLDER)/EpsilonDFU.o

include src/Makefile


OBJECTS  := $(SRC:%.cpp=$(OBJ_DIR)/%.o)

all: build $(TARGET)

$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	@echo "CXX   $<"
	@$(CXX)  $(CXXFLAGS) -c $< -o $@

$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	@echo "LD    $@"
	@$(LD) $(LDFLAGS) -o $@ $^

.PHONY: all build clean debug release

debug: CXXFLAGS += -DDEBUG -g -O0
debug: all

release: CXXFLAGS += -Oz
release: all

clean:
	@rm -rvf $(OBJ_DIR)/* > /dev/null
	@rm -rvf $(TARGET)/* > /dev/null
	@echo "Cleaned !"