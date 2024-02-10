CC = cc
LIBS = -lc -lm
FLAGS = -O3 -static

all: main.elf

%.o: %.s
	$(CC) $(FLAGS) -c -o $@ $<

%.o: $(ARCH_DIR)/%.s
	$(CC) $(FLAGS) -c -o $@ $<

%.o: %.c
	$(CC) ${FLAGS} -c -o $@ $<

%.o: $(ARCH_DIR)/%.c
	$(CC) ${FLAGS} -c -o $@ $<

main.elf: $(OBJS)
	$(CC) $(FLAGS) $(OBJS) $(LIBS) -o main.elf
	objdump -d main.elf > main.lst
	objcopy main.elf main.bin -O binary

clean: more_clean
	rm -rf *.o *.elf output* *.lst *.bin *~
