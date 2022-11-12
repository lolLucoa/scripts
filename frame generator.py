import cv2
import time
import sys
from PIL import Image
from multiprocessing import Process
import os
os.environ['PYGAME_HIDE_SUPPORT_PROMPT'] = "hide"
import pygame
import fpstimer
import moviepy.editor as mp
savefile = open('data.txt', 'a', encoding='utf-8')

emojies = {
    "🤍": [255, 255, 255],
    "🐚": [220, 220, 220],
    "💿": [192, 192, 192],
    "🦝": [128, 128, 128],
    "🌑": [60, 60, 60],
    "🖤": [0, 0, 0],
    "🟠": [225, 100, 0],
    "❤️": [255, 0, 0],
    "🍒": [128, 0, 0],
    "💜": [150, 0, 255],
    "🌸": [255, 0, 230],
    "🫓": [220, 170, 110],
    "🥪": [220, 190, 190],
    "🌳": [30, 100, 30],
    "📗": [30, 230, 60],
    "🦖": [25, 140, 45],
    "🍋": [230, 230, 0],
    "🔵": [0, 0, 255],
    "📘": [0, 160, 255],
    "🐋": [0, 200, 255]
    }
emojies = {
    "🤍": [255, 255, 255],
    "💿": [192, 192, 192],
    "🌑": [60, 60, 60],
    "🖤": [0, 0, 0],
    "❤️": [255, 0, 0],
    "🍒": [128, 0, 0],
    "💜": [150, 0, 255],
    "🌸": [255, 0, 230],
    "🌳": [30, 100, 30],
    "📗": [30, 230, 60],
    "🦖": [25, 140, 45],
    "🍋": [230, 230, 0],
    "🔵": [0, 0, 255],
    "📘": [0, 160, 255],
    "🐋": [0, 200, 255]
    }
    
frame_size = 61 # change  to emojies that can fit (60 for terminal)
frame_height = 30 # 32 for terminal
frame_interval = 1.0 / 30.75

ASCII_LIST = []


# Extract frames from video
def extract_transform_generate(video_path, start_frame, number_of_frames=1000):
    capture = cv2.VideoCapture(video_path)
    capture.set(1, start_frame)  # Points cap to target frame
    current_frame = start_frame
    frame_count = 1
    ret, image_frame = capture.read()
    while ret and frame_count <= number_of_frames:
        ret, image_frame = capture.read()
        try:
            image = Image.fromarray(image_frame)
            ascii_characters = pixels_to_ascii(resize_image(image))  # get ascii characters
            pixel_count = len(ascii_characters)
            ascii_image = "\n".join(
                [ascii_characters[index:(index + frame_size)] for index in range(0, pixel_count, frame_size)])
            ASCII_LIST.append(ascii_image)
        except Exception as error:
            continue

        progress_bar(frame_count, number_of_frames)

        frame_count += 1  # increases internal frame counter
        current_frame += 1  # increases global frame counter

    capture.release()


# Progress bar code is courtesy of StackOverflow user: Aravind Voggu.
# Link to thread: https://stackoverflow.com/questions/6169217/replace-console-output-in-python
def progress_bar(current, total, barLength=25):
    progress = float(current) * 100 / total
    arrow = '#' * int(progress / 100 * barLength - 1)
    spaces = ' ' * (barLength - len(arrow))
    sys.stdout.write('\rProgress: [%s%s] %d%% Frame %d of %d frames' % (arrow, spaces, progress, current, total))


# Resize image
def resize_image(image_frame):
    width, height = image_frame.size
    aspect_ratio = (height / float(width * 2.5))  # 2.5 modifier to offset vertical scaling on console
    new_height = int(aspect_ratio * frame_size)
    new_height = frame_height #change to 32 for terminal
    resized_image = image_frame.resize((frame_size, new_height))
    # print('Aspect ratio: %f' % aspect_ratio)
    # print('New dimensions %d %d' % resized_image.size)
    return resized_image


# Greyscale
def toemoji(pixel):
    closestint = 100000000000000000
    closestcolour = ""
    r, g, b = pixel[0], pixel[1], pixel[2]
    for emoji, colour in emojies.items():
        totalint = (
            ((r - colour[0]) ** 2)
            + ((g - colour[1]) ** 2)
            + ((b - colour[2]) ** 2) ** (1 / 2)
        )
        if totalint < closestint:
            closestint = totalint
            closestcolour = emoji
    return closestcolour


# Convert pixels to ascii
def pixels_to_ascii(image_frame):
    pixels = image_frame.getdata()
    characters = "".join([toemoji(pixel) for pixel in pixels])
    return characters


# Open image => Resize => Greyscale => Convert to ASCII => Store in text file
def ascii_generator(image_path, start_frame, number_of_frames):
    current_frame = start_frame
    while current_frame <= number_of_frames:
        path_to_image = image_path + '/BadApple_' + str(current_frame) + '.jpg'
        image = Image.open(path_to_image)
        ascii_characters = pixels_to_ascii(resize_image(image))  # get ascii characters
        pixel_count = len(ascii_characters)
        ascii_image = "\n".join(
            [ascii_characters[index:(index + frame_size)] for index in range(0, pixel_count, frame_size)])
        current_frame += 1


def preflight_operations(path):
    if os.path.exists(path):
        path_to_video = path.strip()
        cap = cv2.VideoCapture(path_to_video)
        total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
        cap.release()

        frames_per_process = int(total_frames / 4)

        process1_end_frame = frames_per_process
        process2_start_frame = process1_end_frame + 1
        process2_end_frame = process2_start_frame + frames_per_process
        process3_start_frame = process2_end_frame + 1
        process3_end_frame = process3_start_frame + frames_per_process
        process4_start_frame = process3_end_frame + 1
        process4_end_frame = total_frames - 1

        start_time = time.time()
        sys.stdout.write('Beginning ASCII generation...\n')
        extract_transform_generate(path_to_video, 1, process4_end_frame)
        savefile.write('\t'.join(ASCII_LIST))
        savefile.close()
        execution_time = time.time() - start_time
        sys.stdout.write('ASCII generation completed! ASCII generation time: ' + str(execution_time))
        return total_frames

    else:
        sys.stdout.write('Warning file not found!\n')


def main():
    while True:
        sys.stdout.write('==============================================================\n')
        sys.stdout.write('Select option: \n')
        sys.stdout.write('1) Play\n')
        sys.stdout.write('2) Exit\n')
        sys.stdout.write('==============================================================\n')

        user_input = str(input("Your option: "))
        user_input.strip()  # removes trailing whitespaces

        if user_input == '1':
            user_input = str(input("Please enter the video file name (file must be in root!): "))
            preflight_operations(user_input)
        elif user_input == '2':
            exit()
        else:
            sys.stdout.write('Unknown input!\n')
            continue


if __name__ == '__main__':
    main()